if [ `pwd` = "$HOME" ]; then
  if [ ! -d ~/working_dir/ ]; then; mkdir -p ~/working_dir/ ; fi
  cd ~/working_dir/
fi
