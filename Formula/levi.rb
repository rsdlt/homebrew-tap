class Levi < Formula
  desc "Git diff viewer: commits, their files and diffs, with fzf-style search"
  homepage "https://github.com/rsdlt/levi"
  url "https://github.com/rsdlt/levi/archive/refs/tags/v0.20.0.tar.gz"
  sha256 "9555eacc248fa7660ecca999c8c90f74b90227a92b714f0452b8d228826c8fcf"
  license "MIT"
  head "https://github.com/rsdlt/levi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/levi-0.19.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "757ede6bc0803d275e8eb67228bfb9a7a63e5541f1a22bf4971824fb454c68f1"
    sha256 cellar: :any,                 x86_64_linux:  "3aa41cb10cd9571f2c35cc785deca87f2e9cbfa0bb050f27b21e9fd9e3328fad"
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
