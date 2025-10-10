class Pop < Formula
  desc "Swiss-army knife for Polkadot development"
  homepage "https://github.com/r0gue-io/pop-cli"
  version "0.10.0"
  license "GPL-3.0"

  if Hardware::CPU.arm?
    url "https://github.com/r0gue-io/pop-cli/releases/download/v0.10.0/pop-aarch64-apple-darwin.tar.gz"
    sha256 "df0cca5fd1610854a44a0dedaf3c0f95c9b14a9525ee4fccd43d48026bb656ea"
  else
    url "https://github.com/r0gue-io/pop-cli/releases/download/v0.10.0/pop-x86_64-apple-darwin.tar.gz"
    sha256 "dcab392de0afe935f865b1824f61e967283bbd2291bae27e6087911c771ac066"
  end

  def install
    bin.install "pop"
  end

  test do
    system "#{bin}/pop", "--version"
  end
end
