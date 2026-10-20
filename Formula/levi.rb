class Levi < Formula
  desc "Git diff viewer: commits, their files and diffs, with fzf-style search"
  homepage "https://github.com/rsdlt/levi"
  url "https://github.com/rsdlt/levi/archive/refs/tags/v0.19.0.tar.gz"
  sha256 "42a6f7c725969eb8c907a1142c863d5198ab35aee7b359b44e9d85218139c0e4"
  license "MIT"
  head "https://github.com/rsdlt/levi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/levi-0.18.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b052b7218130cd41de39e04e8e158ddd8ecab62c86b68335b106a8af4c2f2cc7"
    sha256 cellar: :any,                 x86_64_linux:  "df978c4f61eeb8e34f7f887da41a8b7bb6b8c9fd0936bedfd284e3bce04c779a"
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
