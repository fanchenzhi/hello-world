import SwiftUI
import AVKit

struct ExerciseVideoPlayer: View {
    let videoURL: URL
    @State private var player: AVPlayer
    
    init(videoURL: URL) {
        self.videoURL = videoURL
        self._player = State(initialValue: AVPlayer(url: videoURL))
    }
    
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .frame(height: 250)
            
            HStack(spacing: 20) {
                Button(action: { player.seek(to: .zero) }) {
                    Image(systemName: "backward.fill")
                }
                
                Button(action: {
                    if player.timeControlStatus == .playing {
                        player.pause()
                    } else {
                        player.play()
                    }
                }) {
                    Image(systemName: player.timeControlStatus == .playing ? "pause.fill" : "play.fill")
                }
                
                Button(action: { player.rate = player.rate == 1.0 ? 0.5 : 1.0 }) {
                    Text(player.rate == 1.0 ? "1.0x" : "0.5x")
                }
            }
            .font(.title2)
            .padding()
        }
        .onDisappear {
            player.pause()
        }
    }
} 