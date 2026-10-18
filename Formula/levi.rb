class Levi < Formula
  desc "Git diff viewer: commits, their files and diffs, with fzf-style search"
  homepage "https://github.com/rsdlt/levi"
  url "https://github.com/rsdlt/levi/archive/refs/tags/v0.14.0.tar.gz"
  sha256 "affc17574e2369e3f33884346f2c9254de02caf96c176549511658e9298b7e38"
  license "MIT"
  head "https://github.com/rsdlt/levi.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/rsdlt/homebrew-tap/releases/download/levi-0.14.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2c7bf7eb222f11030292647a459e51fdc17018c1f1c2d85938eca0378422bfa9"
    sha256 cellar: :any,                 x86_64_linux:  "90df2cd691d79428db82959ec9c9e9b37618f5222194e240e2e23321274478cf"
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
