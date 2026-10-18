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

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "levi #{version}", shell_output("#{bin}/levi --version")
    assert_match "not inside a git repository", shell_output("#{bin}/levi 2>&1", 1)
  end
end
