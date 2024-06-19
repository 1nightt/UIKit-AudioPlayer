import UIKit
import AVFoundation

// VC АудиоПлеер

final class PlayerViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var albumNameLabel: UILabel!
    @IBOutlet private weak var songImage: UIImageView!
    @IBOutlet private weak var nameOfSongLabel: UILabel!
    @IBOutlet private weak var nameOfArtistLabel: UILabel!
    @IBOutlet private weak var startTimeLabel: UILabel!
    @IBOutlet private weak var timeStopLabel: UILabel!
    @IBOutlet private weak var songSlider: UISlider!
    @IBOutlet private weak var volumeSlider: UISlider!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var playPauseButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    
    var player = AVAudioPlayer()
    var songName = ""
    var artistName = ""
    var imageForSong = UIImage()
    var timer = Timer()
    var timeSong: Double = Double()
    var currentSongIndex = 1
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForAudioPlayer()
        
    }
    
    // MARK: - Private Methods
    private func setupForAudioPlayer() {
        albumNameLabel.text = songName
        albumNameLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        songImage.image = imageForSong
        
        nameOfSongLabel.text = songName
        nameOfSongLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        nameOfArtistLabel.text = artistName
        nameOfArtistLabel.textColor = .lightGray
        nameOfArtistLabel.font = .systemFont(ofSize: 13)
        
        songSlider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        songSlider.tintColor = .systemGreen
        songSlider.maximumValue = Float(player.duration)
        
        volumeSlider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        volumeSlider.tintColor = .lightGray
        volumeSlider.maximumValue = Float(player.volume)
        player.volume = volumeSlider.value
        
        playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        nextButton.setImage(UIImage(named: "next"), for: .normal)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        startTimeLabel.text = ""
        startTimeLabel.textColor = .lightGray
        timeStopLabel.text = ""
        timeStopLabel.textColor = .lightGray
        
    }
    
    @objc private func updateTime() {
        let timePlayed = player.currentTime
        let minutes = Int(timePlayed / 60)
        let seconds = Int(timePlayed.truncatingRemainder(dividingBy: 60))
        startTimeLabel.text = NSString(format: "%02d:%02d", minutes, seconds) as String
        
        let difftime = player.currentTime - timeSong
        let minutes1 = Int(difftime / 60)
        let seconds1 = Int(-difftime.truncatingRemainder(dividingBy: 60))
        timeStopLabel.text = NSString(format: "%02d:%02d", minutes1, seconds1) as String
        
        songSlider.setValue(Float(self.player.currentTime), animated: false)
    }
    
    
    @IBAction private func songSliderAction(_ sender: UISlider) {
        self.player.currentTime = TimeInterval(self.songSlider.value)
    }
    
    @IBAction private func volumeSliderAction(_ sender: UISlider) {
        self.player.volume = self.volumeSlider.value
    }
    
    @IBAction private func backButtonAction(_ sender: UIButton) {
        if self.currentSongIndex < 2 {
            self.currentSongIndex += 1
        } else {
            self.currentSongIndex = 1
        }
        
        let audioPath = Bundle.main.path(forResource: "song\(currentSongIndex)", ofType: "mp3")
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        
        if audioPath == Bundle.main.path(forResource: "song1", ofType: "mp3") {
            albumNameLabel.text = "Туда Сюда Миллионер"
            songImage.image = UIImage(named: "Туда сюда")
            nameOfSongLabel.text = "Туда Сюда Миллионер"
            nameOfArtistLabel.text = "Scally Milano, uglystephan"
            timeSong = 130
        }
        
        if audioPath == Bundle.main.path(forResource: "song2", ofType: "mp3") {
            albumNameLabel.text = "Айтишник"
            songImage.image = UIImage(named: "Айтишник")
            nameOfSongLabel.text = "Айтишник"
            nameOfArtistLabel.text = "Нексюша"
            timeSong = 130
        }
        self.player.play()
        self.player.volume = volumeSlider.value
    }
    
    @IBAction private func playPauseButtonAction(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    @IBAction private func nextButtonAction(_ sender: UIButton) {
        if self.currentSongIndex < 2 {
            self.currentSongIndex += 1
        } else {
            self.currentSongIndex = 1
        }
        
        let audioPath = Bundle.main.path(forResource: "song\(currentSongIndex)", ofType: "mp3")
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        
        if audioPath == Bundle.main.path(forResource: "song1", ofType: "mp3") {
            albumNameLabel.text = "Туда Сюда Миллионер"
            songImage.image = UIImage(named: "Туда сюда")
            nameOfSongLabel.text = "Туда Сюда Миллионер"
            nameOfArtistLabel.text = "Scally Milano, uglystephan"
            timeSong = 130
        }
        
        if audioPath == Bundle.main.path(forResource: "song2", ofType: "mp3") {
            albumNameLabel.text = "Айтишник"
            songImage.image = UIImage(named: "Айтишник")
            nameOfSongLabel.text = "Айтишник"
            nameOfArtistLabel.text = "Нексюша"
            timeSong = 130
        }
        self.player.play()
        self.player.volume = self.volumeSlider.value
    }
    
    @IBAction private func closeButton(_ sender: UIButton) {
        self.player.pause()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func shareButton(_ sender: UIButton) {
        let items1 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "song1", ofType: "mp3")!)
        let items2 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "song2", ofType: "mp3")!)
        
        let audioPath = Bundle.main.path(forResource: "song\(currentSongIndex)", ofType: "mp3")
        
        if audioPath == Bundle.main.path(forResource: "song1", ofType: "mp3") {
            let activityVC = UIActivityViewController(activityItems: [items1], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        } else {
            let activityVC = UIActivityViewController(activityItems: [items2], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
}
