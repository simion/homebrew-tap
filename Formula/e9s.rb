class E9s < Formula
  desc "A read-only, k9s-style terminal UI for AWS: ECS, CloudWatch Logs, load balancers, autoscaling"
  homepage "https://github.com/simion/e9s"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.3.0/e9s-aarch64-apple-darwin.tar.xz"
      sha256 "a8cc2dd499fe8658e72f5925eeedea58d84bdfb26791c960eab64fbeb772b30c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.3.0/e9s-x86_64-apple-darwin.tar.xz"
      sha256 "79fbb19113673c66993b3a825780c22d84c2effbd43bad4cd388d91303c1480a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.3.0/e9s-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "70e44428e191e9fb565cdf31c55c89710188999278be0d5c8d30b1d42e26024f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.3.0/e9s-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0d0c6db49fe4301dd3e57050de58b77304bc013caf3609be919d89d2f633ac4d"
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
