class Levi < Formula
  desc "Git diff viewer: commits, their files and diffs, with fzf-style search"
  homepage "https://github.com/rsdlt/levi"
  url "https://github.com/rsdlt/levi/archive/refs/tags/v0.13.0.tar.gz"
  sha256 "00146f853b65d52e5814e7e564a0d0426536606476c794f4ef539e8eefeb750f"
  license "MIT"
  head "https://github.com/rsdlt/levi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/levi-0.13.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "aba39cb9f83575f43ead62664836aa714c14d3189db98cdeec7458934a6462a0"
    sha256 cellar: :any,                 x86_64_linux:  "af4f527b0e5bfa6cf525b1f898abe7a5b777f29f6968cccbd9d28529977dfcd5"
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
