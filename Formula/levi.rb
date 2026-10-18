class Levi < Formula
  desc "Git diff viewer: commits, their files and diffs, with fzf-style search"
  homepage "https://github.com/rsdlt/levi"
  url "https://github.com/rsdlt/levi/archive/refs/tags/v0.16.0.tar.gz"
  sha256 "359c71fedae0d35d47ad7b0fc046f82cae61580990e562a73db57aad6b6cb74f"
  license "MIT"
  head "https://github.com/rsdlt/levi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/levi-0.16.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bd3255ae39b9df02836633ce8cca239d7f2915bd601a59c38116fc0a87a81cd3"
    sha256 cellar: :any,                 x86_64_linux:  "c82a87d8aae67971646bf5e838db0f7909799fdb34c4dd120fdf908edf9fc68c"
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
