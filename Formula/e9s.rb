class E9s < Formula
  desc "A read-only, k9s-style terminal UI for AWS: ECS, CloudWatch Logs, load balancers, autoscaling"
  homepage "https://github.com/simion/e9s"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.1.0/e9s-aarch64-apple-darwin.tar.xz"
      sha256 "fb86a9c2cf5d9446a991ca13f41a29e1fd2ae95119da948441530412d75765ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.1.0/e9s-x86_64-apple-darwin.tar.xz"
      sha256 "f44500ae0ceeb45b97b9b3eacf3ff13b6eaa09a0e23dff7b946180b62a939fcb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.1.0/e9s-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ba28bf58eec0cdae3e62d12f06f2b0d70dcae7ae16916b2306e7431ede880b5c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.1.0/e9s-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6c1cdb8b129ed3fe60e24181d08b3e8b798622dbcacb96a3160fd9f9a08c3ce4"
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
