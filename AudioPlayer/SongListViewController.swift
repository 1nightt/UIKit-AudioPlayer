import UIKit
import AVFoundation

// VC, который показывает список песен

final class SongListViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var firstSongImage: UIImageView!
    @IBOutlet private weak var secondSongImage: UIImageView!
    @IBOutlet private weak var firstNameSongButton: UIButton!
    @IBOutlet private weak var secondNameSongButton: UIButton!
    @IBOutlet private weak var firstTimeSongLabel: UILabel!
    @IBOutlet private weak var secondTimeSongLabel: UILabel!
    @IBOutlet private weak var firstNameOfArtistLabel: UILabel!
    @IBOutlet private weak var secondNameOfArtistLabel: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForSongs()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "song1" {
            let secondVC = segue.destination as? PlayerViewController
            secondVC?.songName = firstNameSongButton.titleLabel?.text ?? ""
            secondVC?.artistName = firstNameOfArtistLabel.text ?? ""
            secondVC?.imageForSong = firstSongImage.image!
            secondVC?.timeSong = 130
            
            do {
                if let audioPath = Bundle.main.path(forResource: "song1", ofType: "mp3") {
                    try secondVC?.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                }
            } catch {
                print("Error!")
            }
            secondVC?.player.play()
        }
        
        if segue.identifier == "song2" {
            let secondVC = segue.destination as? PlayerViewController
            
            secondVC?.songName = secondNameSongButton.titleLabel?.text ?? ""
            secondVC?.artistName = secondNameOfArtistLabel.text ?? ""
            secondVC?.imageForSong = secondSongImage.image!
            secondVC?.timeSong = 130
            
            do {
                if let audioPath = Bundle.main.path(forResource: "song2", ofType: "mp3") {
                    try secondVC?.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                }
            } catch {
                print("Error!")
            }
            secondVC?.player.play()
        }
    }
    
    // MARK: - Private Methods
    private func setupForSongs() {
        firstSongImage.image = UIImage(named: "Туда сюда")
        secondSongImage.image = UIImage(named: "Айтишник")
        
        firstNameSongButton.setTitle("Туда Сюда Миллионер", for: .normal)
        firstNameSongButton.tintColor = .black
        firstNameSongButton.contentHorizontalAlignment = .left
        firstNameSongButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        firstTimeSongLabel.text = "2:10"
        firstTimeSongLabel.textColor = .lightGray
        firstNameOfArtistLabel.text = "Scally Milano, uglystephan"
        firstNameOfArtistLabel.textColor = .lightGray
        firstNameOfArtistLabel.font = .systemFont(ofSize: 13)
        
        secondNameSongButton.setTitle("Айтишник", for: .normal)
        secondNameSongButton.tintColor = .black
        secondNameSongButton.contentHorizontalAlignment = .left
        secondNameSongButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        secondTimeSongLabel.text = "2:10"
        secondTimeSongLabel.textColor = .lightGray
        secondNameOfArtistLabel.text = "Нексюша"
        secondNameOfArtistLabel.textColor = .lightGray
        secondNameOfArtistLabel.font = .systemFont(ofSize: 13)
    }
    

}

