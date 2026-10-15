class E9s < Formula
  desc "A read-only, k9s-style terminal UI for AWS: ECS, CloudWatch Logs, load balancers, autoscaling"
  homepage "https://github.com/simion/e9s"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.1.1/e9s-aarch64-apple-darwin.tar.xz"
      sha256 "7235e7f858b6187f3fa49a91d42770840d3ea611ee394232079653f916f25806"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.1.1/e9s-x86_64-apple-darwin.tar.xz"
      sha256 "0b196360aaff7b601e04613d341c621e9315cb9de69955ffe2a4b090c4c71e1d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/simion/e9s/releases/download/v0.1.1/e9s-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9f78fecddb5951b1016269af3f100e9f773e3c8d42f035ae34dbd06fa21f7566"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simion/e9s/releases/download/v0.1.1/e9s-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "161847f882b0ea8d02994078039a4b795a9338c8a09c9d6acdee6ec8cb82776a"
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
