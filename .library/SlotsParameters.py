# pip install attrs
import attrs

def check_age_positive(instance,attribute,value):
    if value<=0:
        raise ValueError(f"{attribute.age} must be positive")
    
@attrs.define
class Student:
    # 以下属性均为可选构造器参数
    name: str=attrs.field(default="david")
    age: int=attrs.field(default=18,validator=check_age_positive)
    classes: str=attrs.field(default='A')

student_david=Student(age=30,classes='C')
# validator_student=Student(age=0)
# 当返回异常时，该对象实例化不会成功

# 序列化为字典
dict_david=attrs.asdict(student_david)
# 序列化为元组
tuple_david=attrs.astuple(student_david)
