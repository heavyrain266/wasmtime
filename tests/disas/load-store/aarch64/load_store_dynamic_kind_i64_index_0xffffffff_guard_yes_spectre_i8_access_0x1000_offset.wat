;;! target = "aarch64"
;;! test = "compile"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation -W memory64 -O static-memory-maximum-size=0 -O static-memory-guard-size=4294967295 -O dynamic-memory-guard-size=4294967295"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i64 1)

  (func (export "do_store") (param i64 i32)
    local.get 0
    local.get 1
    i32.store8 offset=0x1000)

  (func (export "do_load") (param i64) (result i32)
    local.get 0
    i32.load8_u offset=0x1000))

;; wasm[0]::function[0]:
;;       stp     x29, x30, [sp, #-0x10]!
;;       mov     x29, sp
;;       ldr     x10, [x0, #0x68]
;;       ldr     x12, [x0, #0x60]
;;       mov     x11, #0
;;       add     x12, x12, x2
;;       add     x12, x12, #1, lsl #12
;;       cmp     x2, x10
;;       csel    x11, x11, x12, hi
;;       csdb
;;       strb    w3, [x11]
;;       ldp     x29, x30, [sp], #0x10
;;       ret
;;
;; wasm[0]::function[1]:
;;       stp     x29, x30, [sp, #-0x10]!
;;       mov     x29, sp
;;       ldr     x10, [x0, #0x68]
;;       ldr     x12, [x0, #0x60]
;;       mov     x11, #0
;;       add     x12, x12, x2
;;       add     x12, x12, #1, lsl #12
;;       cmp     x2, x10
;;       csel    x11, x11, x12, hi
;;       csdb
;;       ldrb    w0, [x11]
;;       ldp     x29, x30, [sp], #0x10
;;       ret
