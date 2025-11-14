class Pop < Formula
  desc "Swiss-army knife for Polkadot development"
  homepage "https://github.com/r0gue-io/pop-cli"
  version "0.12.0"
  license "GPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.12.0/pop-aarch64-apple-darwin.tar.gz"
      sha256 "358a7fd2209f68a9e878d86b294abb656f03b71dcda665c7ee88e1021b9e0ead"
    else
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.12.0/pop-x86_64-apple-darwin.tar.gz"
      sha256 "62eb0d80831b9df99aeddef052ac571cdab5b84195cb8dcdbc8bc044497a373b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.12.0/pop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b86d9835f7faaa6e716b40c57ff507a9fdab5a27882a5786337e610cabeb36ef"
    else
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.12.0/pop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "434cd246ed99356838a3fe464a5d7d4a7ee9c073597f20b07ecfc3804d7a5510"
    end
  end

  def install
    bin.install "pop"
  end

  test do
    system "#{bin}/pop", "--version"
  end
end
