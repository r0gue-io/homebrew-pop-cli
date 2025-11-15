class Pop < Formula
  desc "Swiss-army knife for Polkadot development"
  homepage "https://github.com/r0gue-io/pop-cli"
  version "0.12.1"
  license "GPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.12.1/pop-aarch64-apple-darwin.tar.gz"
      sha256 "6120308e8cfe34f4f6ca5c84f3abfbbaa69396e1a75ed44454cdf99203d3a00b"
    else
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.12.1/pop-x86_64-apple-darwin.tar.gz"
      sha256 "77cf527e888e3dd224e6273b375734623c1e3a9b058d72284fcd92d3ef028680"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.12.1/pop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "477235a417aa3be861263233577c4776bb397f913d550c513a4e2b80b3e1ea26"
    else
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.12.1/pop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d89bee25c5eb2e5b992c15afd44cbc0cab64dd5fe303cd9af96ec4b487baf932"
    end
  end

  def install
    bin.install "pop"
  end

  test do
    system "#{bin}/pop", "--version"
  end
end
