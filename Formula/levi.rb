class Levi < Formula
  desc "Git diff viewer: commits, their files and diffs, with fzf-style search"
  homepage "https://github.com/rsdlt/levi"
  url "https://github.com/rsdlt/levi/archive/refs/tags/v0.11.1.tar.gz"
  sha256 "a380bc85d365409fbce817195c0f30a13f695970239f35ce501bca9ab2434ee1"
  license "MIT"
  head "https://github.com/rsdlt/levi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/levi-0.11.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2063ab6f1f6a65f1f998c5da885e027a6a77cb49ae5f8cac791df0e0cf155e74"
    sha256 cellar: :any,                 x86_64_linux:  "918f56c090784485ab07081a0e1764ef2eb543cc6b5b30d85cc8edce350f9cf4"
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
