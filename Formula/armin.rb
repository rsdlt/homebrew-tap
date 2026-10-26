class Armin < Formula
  desc "Autocomplete for zsh: a menu of your likeliest commands, ranked from history"
  homepage "https://github.com/rsdlt/armin"
  url "https://github.com/rsdlt/armin/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "b1b1a3862ceae89f3900a93fb3fdd16af2881de4dc259e8bd85c5a29ac71c936"
  license "MIT"
  head "https://github.com/rsdlt/armin.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/armin-0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "73fef4f0ec910a7c49195ae1738da3ce3dcd0dc2c438bafad5cb84e23f988c62"
    sha256 cellar: :any,                 x86_64_linux:  "0d03f3abe90e4568f5e5e4a273b7c6585c73be27c46eaf1d12479043932f61ab"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      Add armin to ~/.zshrc, with zsh's completion system for Tab's menu,
      and bring in your history once:
        autoload -Uz compinit && compinit
        eval "$(armin init zsh)"
        armin import
      Remove zsh-autosuggestions if you use it: both draw in the same place.
    EOS
  end

  test do
    assert_match "armin #{version}", shell_output("#{bin}/armin --version")
    assert_match "_armin_bin='#{bin}/armin'", shell_output("#{bin}/armin init zsh")

    ENV["ARMIN_DATA_DIR"] = testpath
    system bin/"armin", "record", "--time", "1700000000", "--duration", "5", "--exit", "0",
           "--session", "test", "--cwd", testpath, "--", "git status"
    assert_match "git status", shell_output("#{bin}/armin suggest --cwd #{testpath} -- git")
  end
end
