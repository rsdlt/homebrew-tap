class Levi < Formula
  desc "Git diff viewer: commits, their files and diffs, with fzf-style search"
  homepage "https://github.com/rsdlt/levi"
  url "https://github.com/rsdlt/levi/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "9940801c651c0e7bedfe709b7b5e19744b899971619b4e3df2c277b066b235ae"
  license "MIT"
  head "https://github.com/rsdlt/levi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/levi-0.12.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "494b5bbdc4462d1d74c8d5c4d07fae688b34685116ada3a0c87393e072f170e0"
    sha256 cellar: :any,                 x86_64_linux:  "5ab62b8ef723c2e7e15d7b0ae71289835ba41cf40c1cf9a8ff28c8fb366aad98"
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
