class E9s < Formula
  desc "A k9s-style terminal UI for AWS, read-only by default: ECS, CloudWatch Logs, load balancers, autoscaling"
  homepage "https://github.com/simion/e9s"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.6.1/e9s-aarch64-apple-darwin.tar.xz"
      sha256 "85c54804c07a3dea60f0691b1de03cb4cc0e3bcdf74af9671277952cca5dbf49"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.6.1/e9s-x86_64-apple-darwin.tar.xz"
      sha256 "8767a45c94ba48e2f12d79db5b8bc829555b6c22eab613d1775bfb570bec7fcb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.6.1/e9s-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0163b5f601af83fabc61ae177d9efcf5a6453370c4f08c56aebe413c5d73ae0e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.6.1/e9s-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb9f56a59f1827271471fe3f17d03f717b82861c86be09b9623e31709a893330"
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
