class Levi < Formula
  desc "Git diff viewer: commits, their files and diffs, with fzf-style search"
  homepage "https://github.com/rsdlt/levi"
  url "https://github.com/rsdlt/levi/archive/refs/tags/v0.14.1.tar.gz"
  sha256 "91605797e7eac7c27f373cce5102845f8ff908aef589c73e107d5e4aaec9ee8e"
  license "MIT"
  head "https://github.com/rsdlt/levi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/levi-0.14.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ccb2cba7a650675c429898fc96aa2f88e2b3f6f9deebf5cca963334b31a19cc2"
    sha256 cellar: :any,                 x86_64_linux:  "0d1918f40bb413c7cbce6bd78cbb9b726d5bde1c50eaf473bee23b6f403820c5"
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
