class E9s < Formula
  desc "A k9s-style terminal UI for AWS, read-only by default: ECS, CloudWatch Logs, load balancers, autoscaling"
  homepage "https://github.com/simion/e9s"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.5.1/e9s-aarch64-apple-darwin.tar.xz"
      sha256 "f43c87ce151f9ba2647d82353f2800fc306fc2b13a8a4ce8db4a52fc0046d732"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.5.1/e9s-x86_64-apple-darwin.tar.xz"
      sha256 "47f8c44c11d0dd387b1e1d94f60aebd6384833a0fcbebe830c4398462f953b88"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.5.1/e9s-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "df6dfc115b6873a6f9419c10933167fb7bd4d33639c1a080d0073cd06cb72e6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.5.1/e9s-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "973fd1d1bf8f056d1dd160a081958bde9603385e83e48c57fa36e5bd4d544a0a"
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
