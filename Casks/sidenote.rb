cask "sidenote" do
  version "0.1.7"
  sha256 "f7d75acbc692004b30061974252ef26c1b9af5842da05a4711e055b42d26bf38"

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
