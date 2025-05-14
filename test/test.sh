ANSW=$(curl http://127.0.0.1:3030/time)
if [ "$ANSW" != "" ]; then
  exit 1
else
  echo "Integration Test PASS"
fi
