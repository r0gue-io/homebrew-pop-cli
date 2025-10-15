class Pop < Formula
  desc "Swiss-army knife for Polkadot development"
  homepage "https://github.com/r0gue-io/pop-cli"
  version "0.10.0"
  license "GPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.10.0/pop-aarch64-apple-darwin.tar.gz"
      sha256 "df0cca5fd1610854a44a0dedaf3c0f95c9b14a9525ee4fccd43d48026bb656ea"
    else
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.10.0/pop-x86_64-apple-darwin.tar.gz"
      sha256 "dcab392de0afe935f865b1824f61e967283bbd2291bae27e6087911c771ac066"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.10.0/pop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "255a6161c46adca47fd55c78f84c564a07aa7a3a502f73ef0b9d8f08950190e5"
    else
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.10.0/pop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c943a9804a0f27362489db7fafa79dd5ca18102884f29af033519c8ed71e0764"
    end
  end

  def install
    bin.install "pop"
  end

  test do
    system "#{bin}/pop", "--version"
  end
end
