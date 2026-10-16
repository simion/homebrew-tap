class E9s < Formula
  desc "A read-only, k9s-style terminal UI for AWS: ECS, CloudWatch Logs, load balancers, autoscaling"
  homepage "https://github.com/simion/e9s"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.2.0/e9s-aarch64-apple-darwin.tar.xz"
      sha256 "d48f51bd885704648b1ca6051001c8f3c8d1c53ec9058f09d63b6fefe65463f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.2.0/e9s-x86_64-apple-darwin.tar.xz"
      sha256 "b7fbacb891c3c9322e79596d94dca8f97ae452f7b4ea36b181460e92c8f73323"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.2.0/e9s-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3db672b7dad2b494e15d6cb99cbd597ac3f30dacfff719489c3950f2ff438c5b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.2.0/e9s-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7ca86b9e87cb9dc95bf5d41a4662a8976253b01df5e374a30e556631bc56b11e"
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
