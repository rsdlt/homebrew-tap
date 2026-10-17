class Levi < Formula
  desc "Git diff viewer: commits, their files and diffs, with fzf-style search"
  homepage "https://github.com/rsdlt/levi"
  url "https://github.com/rsdlt/levi/archive/refs/tags/v0.11.2.tar.gz"
  sha256 "675d1db50924cca5fe5af67118701cadf2b9a8b8c62132b9bfac650af4a35e83"
  license "MIT"
  head "https://github.com/rsdlt/levi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/levi-0.11.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "517c24045d6b143a5846a24ecf685dd0990da73b48e0a053ad30f71dca2a6e81"
    sha256 cellar: :any,                 x86_64_linux:  "356fccd21fbbd5163e347c9fc0885191b81a5818d54ed78b5e380c9c23a42a91"
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
