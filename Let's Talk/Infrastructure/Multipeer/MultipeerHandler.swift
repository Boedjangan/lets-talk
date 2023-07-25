//
//  MultipeerHandler.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 24/07/23.
//

import Foundation
import MultipeerConnectivity

protocol MultipeerHandlerDelegate: AnyObject {
    func assignPlayer(peerID: MCPeerID)
    func removePlayer(peerID: MCPeerID)
    func foundPeer(peerID: MCPeerID)
    func lostPeer(peerID: MCPeerID)
    func didReceive(data: Data, from peerID: MCPeerID)
}
// TODO: sending data belum

class MultipeerHandler: NSObject, ObservableObject {
    weak var delegate :MultipeerHandlerDelegate?
    
    private static let serviceType = "Lets-Talk"
    private var myPeerId = MCPeerID(displayName: UIDevice.current.name)
    var browser: MCNearbyServiceBrowser
    var advertiser: MCNearbyServiceAdvertiser
    private var session : MCSession
    @Published var persons: [MCPeerID] = []
    @Published var pairID: MCPeerID?
    @Published var coupleID: String?
    @Published var coupleName: String?
    @Published var userName:String?
    private var phones: [PhoneModel] = []
    @Published var state: MCSessionState = .notConnected
    //    private let pictReceivedHandler: PictReceivedHandler?
    
    override init(){
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .none)
        browser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: MultipeerHandler.serviceType)
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: ["coupleName" : "codeID"], serviceType: MultipeerHandler.serviceType)
        //        self.pictReceivedHandler = pictReceivedHandler
        super.init()
        session.delegate = self
        browser.delegate = self
        advertiser.delegate = self
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
            let couple = coupleModel(username: self.userName ?? "kosong")
            let data = try? JSONEncoder().encode(couple)
            self.browser.invitePeer(peerID, to: self.session, withContext: data, timeout: TimeInterval(0))
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
                var couple = try? JSONDecoder().decode(coupleModel.self, from: context!)
                print("\(couple?.username ?? "kosong"),<<<data")
                self.coupleName = couple?.username
                invitationHandler(true, self.session)
//
//                var dataToSend = coupleModel(username: self.userName ?? "kosong" )
//                let encodeData = try? JSONEncoder().encode(couple)
//
//                do {
//                    try self.session.send(encodeData!, toPeers: self.session.connectedPeers, with: .reliable)
//
//                }
//                catch{
//                    print(error.localizedDescription)
//                }
            })
            window?.rootViewController?.present(alertController, animated: true)
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
          
            if(peerID.displayName == self.coupleID && (phones.first(where:{$0.phoneId == info!["coupleName"]}) != nil)){
                self.pairID = peerID
                self.coupleID = peerID.displayName
                browser.invitePeer(peerID, to: session, withContext: nil, timeout: 0)
                
            }else{
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
    
}


extension MultipeerHandler: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        DispatchQueue.main.async {
            self.state = state
        }
       
        
        switch state {
        case .connecting:
            print("\(peerID) state: connecting")
           
        case .connected:
            print("\(peerID) state: connected")
            do{
                var dataToSend = coupleModel(username: self.userName ?? "kosong" )
                let encodeData = try? JSONEncoder().encode(dataToSend)
                try self.session.send(encodeData!, toPeers:[peerID], with: .reliable)

            }catch{
                print(error.localizedDescription)
            }
            // nyimpan couple id baru push ke next screen
//            DispatchQueue.main.async {
//                self.pairID = peerID
//                print("disini pairing")
//                //                print(self.pairID as Any)
//            }
        case .notConnected:
            print("\(peerID) state: not connected")
            print("\(state) masuk sini")
            
            DispatchQueue.main.async {
//                guard let index = self.persons.firstIndex(of: peerID) else { return }
//                self.persons.remove(at: index)
                let scenes = UIApplication.shared.connectedScenes
                let windowScenes = scenes.first as? UIWindowScene
                let window = windowScenes?.windows.first
                
                let alert = UIAlertController(title: "Invitation Rejected", message: "\(peerID.displayName) rejected your invitation.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                window?.rootViewController?.present(alert, animated: true)
            }
        default:
            print("\(peerID) state: unknown")
        }
    }
    
    //  disini datanya mau diapain ketika diterima
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        //        guard let pict = try? JSONDecoder().decode(PictModel.self, from: data) else { return }
        //        print(pict.name,"test")
        //        DispatchQueue.main.async {
        //          self.pictReceivedHandler?(pict)
        //        }
        //        delegate?.didReceive(data: data, from: peerID)
        print("sini masuk")
        guard let dataTry = try? JSONDecoder().decode(coupleModel.self, from: data) else {return}
        DispatchQueue.main.async {
            self.coupleName = dataTry.username
        }
       
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
}



