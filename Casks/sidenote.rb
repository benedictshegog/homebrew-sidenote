cask "sidenote" do
  version "0.1.4"
  sha256 "80653d9890b958a8cd3189e593003fb78651a7a1339219d79e5e73713d577388"

  url "https://github.com/benedictshegog/sidenote/releases/download/v#{version}/Sidenote_#{version}_aarch64.dmg"
  name "Sidenote"
  desc "Review markdown written by Claude Code: WYSIWYG editing, comments, replies in place"
  homepage "https://github.com/benedictshegog/sidenote"

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
