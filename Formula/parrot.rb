class Parrot < Formula
  desc "Intelligent roasts of failed commands"
  homepage "https://repos.musicsian.com/parrot.html"
  url "https://github.com/tenseleyFlow/parrot/archive/v1.4.0.tar.gz"
  sha256 "1f55c21e741fc21e01ef6f6e00b4ed49b3afc26bb6c33672e0806469c6ca9538"
  license "MIT"

  depends_on "go" => :build
  depends_on "ollama"

  def install
    system "go", "build", *std_go_args(ldflags: "-w -s")

    # Install shell hook
    share.install "parrot-hook.sh"

    # Install example configuration
    etc.install "config/parrot.toml.example" => "parrot/parrot.toml.example"

    # Install documentation
    doc.install "README.md" if File.exist?("README.md")
  end

  def post_install
    puts "🦜 Setting up Parrot with AI backend..."

    # Start Ollama service if not running (required for model download)
    unless system("pgrep -x ollama >/dev/null 2>&1")
      puts "🚀 Starting Ollama service..."
      system("brew services start ollama")
      # Wait a moment for service to start
      sleep 2
    end

    # Download the lightweight model if not already present
    unless system("ollama list | grep -q 'llama3.2:3b'")
      puts "📥 Downloading AI model (llama3.2:3b) - this may take a few minutes..."
      puts "   This is a one-time setup for maximum roasting power! ☕"
      if system("ollama pull llama3.2:3b")
        puts "✅ AI model ready! Your roasts will be legendary! 🔥"
      else
        puts "❌ Model download failed - falling back to built-in roasts"
      end
    else
      puts "✅ AI model already available - ready to roast! 🔥"
    end

    puts <<~EOS

      🦜 Parrot installation complete!

      🚀 NEXT STEP: Run this command to enable shell integration:
          parrot install

      💡 This adds smart command failure detection to your shell.
         After that, every failed command gets the roasting it deserves! 🔥

      📖 For more options: parrot --help
    EOS
  end

  test do
    # Test basic functionality
    assert_match "parrot", shell_output("#{bin}/parrot --help")

    # Test mock command (should work without backend setup)
    output = shell_output("#{bin}/parrot mock 'git push' 1")
    assert_match "🦜", output

    # Test configuration command
    assert_match "Configuration", shell_output("#{bin}/parrot status")
  end
end