#!/bin/bash
set -euo pipefail

try_rb="/usr/lib/tobi-try/try.rb"
patch_file="$(mktemp)"
zshrc="$HOME/.zshrc"
dot_zshrc="$HOME/Documents/dotfiles/config/zsh/.zshrc"

sudo pacman -S --needed --noconfirm tobi-try

cat > "$patch_file" << 'PATCH_EOF'
--- pristine.rb	2026-08-17 05:43:35.511887891 +0600
+++ try.rb	2026-08-17 05:34:25.766011821 +0600
@@ -7,6 +7,17 @@
 require_relative 'lib/tui'
 require_relative 'lib/fuzzy'
 
+# Date prefix for generated names; disabled with TRY_NO_DATE=1
+def date_prefix
+  return "" if ENV['TRY_NO_DATE'] == '1'
+  Time.now.strftime("%Y-%m-%d")
+end
+
+def prefixed_name(base)
+  prefix = date_prefix
+  prefix.empty? ? base : "#{prefix}-#{base}"
+end
+
 class TrySelector
   include Tui::Helpers
   TRY_PATH = ENV['TRY_PATH'] || File.expand_path("~/src/tries")
@@ -419,11 +430,10 @@
     background = is_selected ? Tui::Palette::SELECTED_BG : nil
     line = screen.body.add_line(background: background)
     line.write << (is_selected ? Tui::Text.highlight("→ ") : "  ")
-    date_prefix = Time.now.strftime("%Y-%m-%d")
     label = if @input_buffer.empty?
-      "📂 Create new: #{date_prefix}-"
+      "📂 Create new: #{prefixed_name('')}"
     else
-      "📂 Create new: #{date_prefix}-#{@input_buffer}"
+      "📂 Create new: #{prefixed_name(@input_buffer)}"
     end
     line.write << label
   end
@@ -774,11 +784,10 @@
 
   def handle_create_new
     # Create new try directory
-    date_prefix = Time.now.strftime("%Y-%m-%d")
 
     # If user already typed a name, use it directly
     if !@input_buffer.empty?
-      final_name = "#{date_prefix}-#{@input_buffer}".gsub(/\s+/, '-')
+      final_name = prefixed_name(@input_buffer).gsub(/\s+/, '-')
       full_path = File.join(@base_path, final_name)
       @selected = { type: :mkdir, path: full_path }
     else
@@ -789,7 +798,7 @@
         show_cursor
         STDERR.puts "Enter new try name"
         STDERR.puts
-        STDERR.print("> #{date_prefix}-")
+        STDERR.print("> #{prefixed_name('')}")
         STDERR.flush
 
         STDERR.cooked do
@@ -802,7 +811,7 @@
 
       return if entry.nil? || entry.empty?
 
-      final_name = "#{date_prefix}-#{entry}".gsub(/\s+/, '-')
+      final_name = prefixed_name(entry).gsub(/\s+/, '-')
       full_path = File.join(@base_path, final_name)
 
       @selected = { type: :mkdir, path: full_path }
@@ -1058,8 +1067,7 @@
     parsed = parse_git_uri(git_uri)
     return nil unless parsed
 
-    date_prefix = Time.now.strftime("%Y-%m-%d")
-    "#{date_prefix}-#{parsed[:user]}-#{parsed[:repo]}"
+    prefixed_name("#{parsed[:user]}-#{parsed[:repo]}")
   end
 
   def is_git_uri?(arg)
@@ -1216,9 +1224,8 @@
       else
         File.basename(repo_dir)
       end
-      date_prefix = Time.now.strftime("%Y-%m-%d")
-      base = resolve_unique_name_with_versioning(tries_path, date_prefix, base)
-      full_path = File.join(tries_path, "#{date_prefix}-#{base}")
+      base = resolve_unique_name_with_versioning(tries_path, base)
+      full_path = File.join(tries_path, prefixed_name(base))
       # Use worktree if .git exists (file in worktrees, directory in regular repos)
       if File.exist?(File.join(repo_dir, '.git'))
         return script_worktree(full_path, repo_dir)
@@ -1363,8 +1370,9 @@
   # If the given base ends with digits and today's dir already exists,
   # bump the trailing number to the next available one for today.
   # Otherwise, fall back to unique_dir_name with -2, -3 suffixes.
-  def resolve_unique_name_with_versioning(tries_path, date_prefix, base)
-    initial = "#{date_prefix}-#{base}"
+  def resolve_unique_name_with_versioning(tries_path, base)
+    prefix = date_prefix
+    initial = prefixed_name(base)
     return base unless Dir.exist?(File.join(tries_path, initial))
 
     m = base.match(/^(.*?)(\d+)$/)
@@ -1373,13 +1381,13 @@
       candidate_num = n + 1
       loop do
         candidate_base = "#{stem}#{candidate_num}"
-        candidate_full = File.join(tries_path, "#{date_prefix}-#{candidate_base}")
+        candidate_full = File.join(tries_path, prefixed_name(candidate_base))
         return candidate_base unless Dir.exist?(candidate_full)
         candidate_num += 1
       end
     else
       # No numeric suffix; use -2 style uniqueness on full name
-      return unique_dir_name(tries_path, "#{date_prefix}-#{base}").sub(/^#{Regexp.escape(date_prefix)}-/, '')
+      unique_dir_name(tries_path, prefixed_name(base)).sub(/^#{prefix}-/, '')
     end
   end
 
@@ -1400,9 +1408,8 @@
     else
       begin; File.basename(File.realpath(repo_dir)); rescue; File.basename(repo_dir); end
     end
-    date_prefix = Time.now.strftime("%Y-%m-%d")
-    base = resolve_unique_name_with_versioning(tries_path, date_prefix, base)
-    File.join(tries_path, "#{date_prefix}-#{base}")
+    base = resolve_unique_name_with_versioning(tries_path, base)
+    File.join(tries_path, prefixed_name(base))
   end
 
   case command
PATCH_EOF

if [ -f "$try_rb" ]; then
  if grep -q "TRY_NO_DATE" "$try_rb"; then
    echo "try: already patched (TRY_NO_DATE supported)"
  elif sudo patch -d /usr/lib/tobi-try -p0 --forward -s < "$patch_file"; then
    echo "try: patched /usr/lib/tobi-try/try.rb to support TRY_NO_DATE"
  else
    sudo rm -f /usr/lib/tobi-try/try.rb.rej /usr/lib/tobi-try/try.rb.orig
    echo "try: WARNING could not apply patch (tobi-try version may have changed)" >&2
  fi
fi
rm -f "$patch_file"

for f in "$zshrc" "$dot_zshrc"; do
  [ -f "$f" ] || continue
  grep -qxF 'export TRY_NO_DATE=1' "$f" || printf 'export TRY_NO_DATE=1\n' >> "$f"
  grep -qxF 'eval "$(try init ~/Work/tries)"' "$f" || printf 'eval "$(try init ~/Work/tries)"\n' >> "$f"
done
echo "try: shell integration ensured in ~/.zshrc"
