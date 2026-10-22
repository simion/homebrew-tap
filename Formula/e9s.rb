class E9s < Formula
  desc "A k9s-style terminal UI for AWS, read-only by default: ECS, CloudWatch Logs, load balancers, autoscaling"
  homepage "https://github.com/simion/e9s"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.5.0/e9s-aarch64-apple-darwin.tar.xz"
      sha256 "2c8e34e0b14571273eeb6b91a4a9c6a23b15c1591828dac4d426d7d4f5fa6a78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.5.0/e9s-x86_64-apple-darwin.tar.xz"
      sha256 "903fd47348a5d9a63757bfc8eb8d7dd97f12ca1d2747ce03bb857398dc2dd75f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.5.0/e9s-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d2a1cb0ade4736c5ae451f372ac1f4a94ea70274aea34e58407762fed8cbac0f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.5.0/e9s-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8ff40b6fcb8d72c6c2513478912090cfcb0cc26cca51906d4650b8e8bcf83711"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "e9s"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "e9s"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "e9s"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "e9s"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
