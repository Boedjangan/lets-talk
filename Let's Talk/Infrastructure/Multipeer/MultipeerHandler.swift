//
//  MultipeerHandler.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 24/07/23.
//

import Foundation
import MultipeerConnectivity

enum CoupleRole: String, CaseIterable {
    case sender = "sender"
    case receiver = "receiver"
}

enum RecordingStatus: String {
    case idle = "idle"
    case start = "start"
    case stop = "stop"
}

protocol MultipeerHandlerDelegate: AnyObject {
    func assignPlayer(peerID: MCPeerID)
    func removePlayer(peerID: MCPeerID)
    func foundPeer(peerID: MCPeerID)
    func lostPeer(peerID: MCPeerID)
    func didReceive(data: Data, from peerID: MCPeerID)
}

class MultipeerHandler: NSObject, ObservableObject {
    weak var delegate: MultipeerHandlerDelegate?
    private static let serviceType = "Lets-Talk"
    
    @Published var persons: [MCPeerID] = []
    @Published var pairID: MCPeerID?
    @Published var coupleID: String?
    @Published var state: MCSessionState = .notConnected
    
    // MARK: - User & Couple Status
    @Published var isReady = false
    @Published var coupleReadyAt = ""
    @Published var coupleRole: CoupleRole?
    @Published var coupleName: String?
    @Published var coupleRecordStatus: RecordingStatus = .idle
    @Published var username: String?
    
    // MARK: - Received File
    @Published var receivedPhotoName: String?
    @Published var receivedAudioName: String?
    
    // MARK: - Warm Up Answer
    @Published var coupleWarmUpAnswer = ""
    
    // MARK: - Timer properties
    private var retryTimer: Timer?
    private let retryDelayInSeconds: TimeInterval = 5.0
    
    private var myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private var session : MCSession
    private var phones: [PhoneModel] = []
    
    var browser: MCNearbyServiceBrowser
    var advertiser: MCNearbyServiceAdvertiser
    
    
    override init() {
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .none)
        browser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: MultipeerHandler.serviceType)
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: ["coupleName" : "codeID"], serviceType: MultipeerHandler.serviceType)
        
        super.init()
        
        session.delegate = self
        browser.delegate = self
        advertiser.delegate = self
    }
    
    func resetState() {
        DispatchQueue.main.async {
            // MARK: - User & Couple Status
            self.coupleRole = nil
            self.coupleRecordStatus = .idle
            
            // MARK: - Received File
            self.receivedPhotoName = nil
            self.receivedAudioName = nil
            
            // MARK: - Warm Up Answer
            self.coupleWarmUpAnswer = ""
        }
    }
    
    func startBrowsing() {
        browser.startBrowsingForPeers()
    }
    
    func stopBrowsing() {
        browser.stopBrowsingForPeers()
    }
    
    var isReceivingImage: Bool = true {
        didSet {
            if isReceivingImage {
                print("start Advertising")
                advertiser.startAdvertisingPeer()
            } else {
                print("stop Advertising")
                advertiser.stopAdvertisingPeer()
            }
        }
    }
    
    // invite peer untuk konek session dengan hp lain, biasanya yang di discoverable
    // mungkin bisa dipakai untuk simpan peratama kali setelah itu gausha pakai lagi, konek pertama kali
    // mungkin di store di coredata peeridnya?
    // kirim couple id disini
    func invitePeer(_ peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.pairID = peerID
            self.coupleID = peerID.displayName
            
            let couple = coupleModel(username: self.username ?? "kosong")
            let data = try? JSONEncoder().encode(couple)
            
            self.browser.invitePeer(peerID, to: self.session, withContext: data, timeout: TimeInterval(0))
        }
    }
    
    // Ini untuk send data ke peer
    func sendData(_ data: Data) {
        guard let peer = session.connectedPeers.first else { return }
        
        do {
            try session.send(data, toPeers: [peer], with: .reliable)
        } catch {
            print("Error sending data: \(error.localizedDescription)")
        }
   }
    
    func sendFile(url: URL, fileName: String, onSuccess: @escaping () -> Void, onFailed: @escaping (_ error: Error) -> Void) {
        guard let peer = session.connectedPeers.first else { return }
        
        session.sendResource(at: url, withName: fileName, toPeer: peer) { error in
            if let error = error {
                print("Error sending file: \(error.localizedDescription)")
                onFailed(error)
            } else {
                print("File sent successfully.")
                onSuccess()
            }
        }
    }
    
    private func saveReceivedFile(at sourceURL: URL, withName fileName: String) {
        let fileManager = FileManager.default
        
        do {
            let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let destinationURL = documentsURL.appendingPathComponent(fileName)
            
            // Check if a file with the same name already exists at the destination
            if fileManager.fileExists(atPath: destinationURL.path) {
                // If the file exists, remove it before moving the new file to the destination
                try fileManager.removeItem(at: destinationURL)
            }

            // Move or copy the file to the app's document directory
            try fileManager.moveItem(at: sourceURL, to: destinationURL)

            // You can perform any additional actions with the saved file here
            print("File saved successfully at: \(destinationURL)")
        } catch {
            // Handle error in saving the file (if needed)
            print("Error saving received file: \(error.localizedDescription)")
        }
    }
    
    func updateDiscoveryInfo() {
        advertiser.stopAdvertisingPeer()
        
        // Modify the discoveryInfo dictionary as needed
        let discoveryInfo = ["customKey": "customValue"] // Replace with your updated custom discovery info data
        
        // Create a new advertiser with the updated discovery info
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: discoveryInfo, serviceType: "your-service-type")
        
        // Set the delegate for the new advertiser
        advertiser.delegate = self
        
        // Start advertising again with the updated discovery info
        advertiser.startAdvertisingPeer()
    }
}

extension MultipeerHandler: MCNearbyServiceAdvertiserDelegate {
    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void
    ) {
        if context == nil{
            invitationHandler(true, self.session)
        }else{
            DispatchQueue.main.async {
                print("nerima invitation")
                
                let scenes = UIApplication.shared.connectedScenes
                let windowScenes = scenes.first as? UIWindowScene
                let window = windowScenes?.windows.first
                
                let title = "Accept \(peerID.displayName)'s invitation"
                let message = "Would you like to accept: \(peerID.displayName)"
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "No", style: .cancel){ _ in
                    let job = try? JSONDecoder().decode(coupleModel.self, from: context!)
                    print("\(job?.username ?? "kosong" ),<<<data")
                    invitationHandler(false, self.session)
                })
                
                alertController.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
                    self.coupleID = peerID.displayName
                    
                    let couple = try? JSONDecoder().decode(coupleModel.self, from: context!)
                    
                    print("\(couple?.username ?? "kosong"),<<<data")
                    self.coupleName = couple?.username ?? ""
                    self.isReady = true
                    
                    invitationHandler(true, self.session)
                })
                
                window?.rootViewController?.present(alertController, animated: true)
            }
        }
        
    }
}


extension MultipeerHandler: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        // disini ngecek ke core data kalau peeridnya sama atau engga dengan couple
        if !persons.contains(peerID) {
            if let info = info {
                print(info["coupleName"] ?? "No Name")
            }
          
            if(peerID.displayName == self.coupleID) {
                self.pairID = peerID
                self.coupleID = peerID.displayName
                
                print("KEPANGGIL!!!")
                
                browser.invitePeer(peerID, to: session, withContext: nil, timeout: 0)
            } else {
                persons.append(peerID)
                phones.append(PhoneModel(displayName: peerID.displayName, phoneId: info?["coupleName"] ?? ""))
            }
            
            print("invite done")
        }
    }
    
    // ini pas moton peer id
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        guard let index = persons.firstIndex(of: peerID) else { return }
        
        persons.remove(at: index)
        DispatchQueue.main.async {
            print("lost peer")
            self.pairID = nil
        }
    }
    
    private func scheduleRetryAlert(peerID: MCPeerID) {
        // Invalidate the previous timer, if any
        invalidateRetryTimer()
        
        // Schedule a new timer to trigger the alert after the specified delay
        retryTimer = Timer.scheduledTimer(withTimeInterval: retryDelayInSeconds, repeats: false) { [weak self] timer in
            self?.showDisconnectedAlert(peerID: peerID)
        }
    }
    
    private func showDisconnectedAlert(peerID: MCPeerID) {
        // Display the alert indicating the disconnection after the specified delay
        // Implement your alert logic here, such as showing an alert view or updating the UI
        DispatchQueue.main.async {
            let scenes = UIApplication.shared.connectedScenes
            let windowScenes = scenes.first as? UIWindowScene
            let window = windowScenes?.windows.first
            
            let alert = UIAlertController(title: "Invitation Rejected", message: "\(peerID.displayName) rejected your invitation.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            window?.rootViewController?.present(alert, animated: true)
        }
    }
    
    private func invalidateRetryTimer() {
        retryTimer?.invalidate()
        retryTimer = nil
    }
}


extension MultipeerHandler: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        DispatchQueue.main.async {
            self.state = state
        }
       
        switch state {
        case .connecting:
            print("\(peerID) state: connecting")
            
            invalidateRetryTimer()
        case .connected:
            print("\(peerID) state: connected")
            
            do {
                let dataToSend = MultipeerData(dataType: .username, data: self.username?.data(using: .utf8) ?? "Kosong".data(using: .utf8))
                let encodedData = try JSONEncoder().encode(dataToSend)
                
                try self.session.send(encodedData, toPeers: [peerID], with: .reliable)
            } catch {
                print(error.localizedDescription)
            }
            
            invalidateRetryTimer()
        case .notConnected:
            print("\(peerID) state: not connected")
            print("\(state) masuk sini")
            
            scheduleRetryAlert(peerID: peerID)
        default:
            print("\(peerID) state: unknown")
        }
    }
    
    // MARK - RECEIVED DATA FROM COUPLE
    // Semua yg di sini diterima dari couple jadi setiap
    // pesannya adalah kondisi atau milik couple
    // disini datanya mau diapain ketika diterima
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let customData = try? JSONDecoder().decode(MultipeerData.self, from: data) {
            switch customData.dataType {
            case .username:
                if  let receivedValue = customData.data {
                    DispatchQueue.main.async {
                        self.coupleName = String(data:receivedValue, encoding: .utf8)
                        self.isReady = true
                    }
                }
            case .role:
                if  let receivedValue = customData.data {
                    DispatchQueue.main.async {
                        guard let value = String(data: receivedValue, encoding: .utf8) else { return }
                        self.coupleRole = CoupleRole(rawValue: value)
                    }
                }
            case .isReadyAt:
                if let receivedValue = customData.data{
                    DispatchQueue.main.async {
                        self.coupleReadyAt = String(data: receivedValue, encoding: .utf8)!
                    }
                }
            case .warmUpAnswer:
                if let receivedValue = customData.data {
                    DispatchQueue.main.async {
                        self.coupleWarmUpAnswer = String(data: receivedValue, encoding: .utf8)!
                    }
                }
            case .startRecording:
                DispatchQueue.main.async {
                    self.coupleRecordStatus = .start
                }
            case .stopRecording:
                DispatchQueue.main.async {
                    self.coupleRecordStatus = .stop
                }
            case .switchRole:
                DispatchQueue.main.async {
                    switch(self.coupleRole) {
                    case .receiver:
                        self.coupleRole = .sender
                    case .sender:
                        self.coupleRole = .receiver
                    default:
                        print("Not found")
                    }
                }
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        if let localURL = localURL {
            print("RECEIVING FILE >>> ", resourceName)
            print("RECEIVING FILE URL >>> ", localURL)
            
            let isAudioFile = resourceName.contains(".m4a")
            
            if isAudioFile {
                DispatchQueue.main.async {
                    self.receivedAudioName = resourceName
                }
            } else {
                DispatchQueue.main.async {
                    self.receivedPhotoName = resourceName
                }
            }
            
            saveReceivedFile(at: localURL, withName: resourceName)
        }
        
        if let error = error {
            print("Error receiving file: \(error.localizedDescription)")
        }
    }
}



