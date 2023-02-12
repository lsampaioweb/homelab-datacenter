# Run on the kvm-07

: << 'MULTILINE-COMMENT'
qm start 100; \
qm start 101; \
qm start 102; \
qm start 103; \
qm start 104; \
qm start 105; \
qm start 106; \
qm start 1000 
MULTILINE-COMMENT

: << 'MULTILINE-COMMENT'
qm shutdown 1000; \
qm shutdown 106; \
qm shutdown 105; \
qm shutdown 104; \
qm shutdown 103; \
qm shutdown 102; \
qm shutdown 101; \
qm shutdown 100 
MULTILINE-COMMENT
