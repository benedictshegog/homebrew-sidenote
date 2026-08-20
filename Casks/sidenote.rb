cask "sidenote" do
  version "0.1.9"
  sha256 "6a8892f096a7803e0d0734e9128c915e82812825f0a97042f16b6127947f0bf3"

  url "https://benedictshegog.xyz/downloads/Sidenote_#{version}_aarch64.dmg"
  name "Sidenote"
  desc "Review markdown written by Claude Code: WYSIWYG editing, comments, replies in place"
  homepage "https://benedictshegog.xyz"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Sidenote.app"
  binary "#{appdir}/Sidenote.app/Contents/MacOS/sidenote"

  # Unsigned build: clear the quarantine flag so Gatekeeper does not block it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Sidenote.app"],
                   sudo: false
  end

  zap trash: [
    "~/.sidenote",
    "~/.claude/skills/sidenote-review",
  ]
end
