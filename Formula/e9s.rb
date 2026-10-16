class E9s < Formula
  desc "A k9s-style terminal UI for AWS, read-only by default: ECS, CloudWatch Logs, load balancers, autoscaling"
  homepage "https://github.com/simion/e9s"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.4.0/e9s-aarch64-apple-darwin.tar.xz"
      sha256 "bf7ef2ba5f629819b98b898160c7ceb92913bb15d6b67745aa45e0ad3ff4c59a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.4.0/e9s-x86_64-apple-darwin.tar.xz"
      sha256 "1d0658c9e6640c7c5211d51ba61c02edbc3a203c94ef026dde19e4c251e01805"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.4.0/e9s-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e2a3959e24c53a17b0b11595982f6cb4c96f6c0943105c6e26cf81cbcebac073"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.4.0/e9s-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6dc85be9eef2f4a44c81944d29c04c3be42dc0b50e972a0102fad83875bfbfa1"
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
