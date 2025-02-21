from algorithm.functional import vectorize
from memory.unsafe import DTypePointer
from sys.info import simdwidthof


fn main():
    alias size: Int = 64
    alias type = DType.int16
    alias els = simdwidthof[type]()
    print(els)

    let p = DTypePointer[type].alloc(size)

    # for i in range(9):
    #     print(i)
    
    @parameter
    fn closure[els: Int](i: Int):
        print("Putting:", els, "elements at:", i)
        p.simd_store[els](i, i)
    
    vectorize[els, closure](size)

    print(p.simd_load[size](0))


struct MyInt:
    var data: Int

    fn __init__(inout self, i:Int):
        self.data = i

