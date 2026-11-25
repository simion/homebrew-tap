class Xkill < Formula
  desc "The macOS equivalent of Linux's xkill: click a window to force-kill its app"
  homepage "https://github.com/simion/xkill"
  # url and sha256 are rewritten by simion/xkill's release workflow on every vX.Y.Z tag
  url "https://github.com/simion/xkill/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "6b5b120570105e833afa588fa9f1aac27dd228d05d0eb28fbd63fa8347e5d4f6"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "-O", "xkill.swift", "-o", "xkill"
    bin.install "xkill"
  end

  test do
    assert_equal "ok", shell_output("#{bin}/xkill --selftest").strip
  end
end
