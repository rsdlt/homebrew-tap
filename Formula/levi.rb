class Levi < Formula
  desc "Git diff viewer: commits, their files and diffs, with fzf-style search"
  homepage "https://github.com/rsdlt/levi"
  url "https://github.com/rsdlt/levi/archive/refs/tags/v0.17.0.tar.gz"
  sha256 "479d21430f6a1a4e2ee2098805b4ac372640df54fb2059f71ed3326a78e004f0"
  license "MIT"
  head "https://github.com/rsdlt/levi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/levi-0.17.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ed6103633b24e5b373137ee7b4df8834522b309bea52d618808545647e4c1e33"
    sha256 cellar: :any,                 x86_64_linux:  "30b91e9eef89035c3a54a1115b247733e1a85680b3bf6576799e8f7cc37d605d"
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
