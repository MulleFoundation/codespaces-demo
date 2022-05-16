#! /bin/bash

mulle-sde init -m foundation/objc-developer executable &&
mulle-sde extension add mulle-objc/vscode-clang && 
cat <<EOF >> .gitignore
# ### > generated by codespaces-demo/.devcontainer/post-create.sh

# generally /var and directories are not interesting
var/


# stash is generally boring
stash/

# build stuff is boring too
build/
kitchen/
dependency/
addiction/
*.tmp/
tmp.*/

# ### < generated by codespaces-demo/.devcontainer/post-create.sh
EOF

