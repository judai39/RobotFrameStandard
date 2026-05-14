def safe_divide(a, b):
    """安全的除法运算"""
    try:
        return a / b
    except ZeroDivisionError as e:
        # 由python库代码处理异常逻辑，返回经过处理后的数据
        raise e

def divide_with_exception(a, b):
    """直接除法，可能抛出异常"""
        # 返回python异常类
    return a / b