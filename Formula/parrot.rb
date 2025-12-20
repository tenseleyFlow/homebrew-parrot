class Parrot < Formula
  desc "Intelligent CLI command failure assistant with AI-powered responses"
  homepage "https://repos.musicsian.com/parrot.html"
  url "https://github.com/tenseleyFlow/parrot/archive/v1.8.2.tar.gz"
  sha256 "23b36bd44b50d833063924d2152e89fcbf28428bc9bfeaaef2322b00b7c9a7cc"
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
