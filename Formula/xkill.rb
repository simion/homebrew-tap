class Xkill < Formula
  desc "The macOS equivalent of Linux's xkill: click a window to force-kill its app"
  homepage "https://github.com/simion/xkill"
  # url and sha256 are rewritten by simion/xkill's release workflow on every vX.Y.Z tag
  url "https://github.com/simion/xkill/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
