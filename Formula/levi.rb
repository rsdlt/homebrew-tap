class Levi < Formula
  desc "Git diff viewer: commits, their files and diffs, with fzf-style search"
  homepage "https://github.com/rsdlt/levi"
  url "https://github.com/rsdlt/levi/archive/refs/tags/v0.15.0.tar.gz"
  sha256 "9cfed67e8767e33c3e4a139fce9673b73b8e02b9655654cfa07797bc231831f9"
  license "MIT"
  head "https://github.com/rsdlt/levi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/levi-0.15.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5dd94f9d7982985261031af48ef0a03035aca9163967eebe3f59f3bbb05c43b9"
    sha256 cellar: :any,                 x86_64_linux:  "2d07b4ea28e49ce2fb2a54b3bd004c3f1a46d28ef84597e9da3b388f1066b545"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "levi #{version}", shell_output("#{bin}/levi --version")
    assert_match "not inside a git repository", shell_output("#{bin}/levi 2>&1", 1)
  end
end
