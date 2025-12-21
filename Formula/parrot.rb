class Parrot < Formula
  desc "Intelligent CLI command failure assistant with AI-powered responses"
  homepage "https://repos.musicsian.com/parrot.html"
  url "https://github.com/tenseleyFlow/parrot/archive/v1.8.9.tar.gz"
  sha256 "d68c04bd352675ef48bf84387b56ac47519e673bd7f287546213e062f8db90e6"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-w -s")

    # Install shell hooks
    share.install "parrot-hook.sh"
    share.install "parrot-hook.fish"

    # Install example configuration
    etc.install "config/parrot.toml.example" => "parrot/parrot.toml.example"

    # Install documentation
    doc.install "README.md" if File.exist?("README.md")
  end

  def caveats
    <<~EOS
      🦜 Parrot has been installed successfully!

      🚀 NEXT STEP: Run this command to enable shell integration:
          parrot install

      💡 This adds smart command failure detection to your shell
         After running it, failed commands will trigger helpful responses!

      📖 For more options, run: parrot --help

      🤖 For AI-powered responses, install Ollama:
         brew install ollama
         brew services start ollama
         ollama pull llama3.2:3b
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
