import Foundation

// 基础动作
let baseExercises = [
    Exercise(
        id: UUID(),
        name: "杠铃卧推",
        category: .chest,
        equipment: "杠铃",
        description: "杠铃卧推是一个经典的胸部训练动作，可以有效锻炼胸大肌、三头肌和前束三角肌。",
        steps: [
            "躺在卧推凳上，双脚平稳踏地",
            "握住杠铃，手臂略宽于肩",
            "控制杠铃缓慢下降至胸部",
            "推起杠铃至起始位置",
            "重复动作"
        ],
        tips: [
            "保持手肘与身体呈45度角",
            "下降时保持肩胛骨收紧",
            "呼吸节奏：下降吸气，推起呼气",
            "注意颈部保持中立位置"
        ],
        targetMuscles: [.pectoralis, .triceps, .deltoids],
        videoURL: nil,
        images: [],
        difficulty: .intermediate
    ),
    Exercise(
        id: UUID(),
        name: "引体向上",
        category: .back,
        equipment: "单杠",
        description: "引体向上是锻炼背部的基础复合动作，主要锻炼背阔肌和肱二头肌。",
        steps: [
            "双手握住单杠，手距略宽于肩",
            "收紧核心，绷紧身体",
            "拉起身体直至下巴超过单杠",
            "控制下降回到起始位置"
        ],
        tips: [
            "避免摆动身体",
            "下降时完全伸展手臂",
            "上拉时注意肩胛骨下沉",
            "保持稳定的呼吸节奏"
        ],
        targetMuscles: [.latissimus, .biceps],
        videoURL: nil,
        images: [],
        difficulty: .advanced
    ),
    Exercise(
        id: UUID(),
        name: "深蹲",
        category: .legs,
        equipment: "杠铃",
        description: "杠铃深蹲是最有效的下肢力量训练动作，可全面锻炼腿部肌群。",
        steps: [
            "将杠铃置于斜方肌上方",
            "双脚略宽于肩，脚尖微外旋",
            "臀部向后坐，同时膝盖弯曲",
            "下蹲至大腿与地面平行",
            "收紧臀部和大腿推回起始位置"
        ],
        tips: [
            "保持核心收紧",
            "膝盖方向与脚尖一致",
            "下蹲时保持胸部挺起",
            "避免膝盖内扣"
        ],
        targetMuscles: [.quadriceps, .hamstrings],
        videoURL: nil,
        images: [],
        difficulty: .intermediate
    ),
    Exercise(
        id: UUID(),
        name: "哑铃推举",
        category: .shoulders,
        equipment: "哑铃",
        description: "哑铃推举是训练三角肌的基础动作，可以有效增强肩部力量。",
        steps: [
            "双手持哑铃站立，哑铃置于肩部位置",
            "掌心相对，手肘指向前方",
            "垂直向上推举哑铃",
            "缓慢下降回到起始位置"
        ],
        tips: [
            "避免过度后仰",
            "保持核心稳定",
            "注意肩胛骨的位置",
            "控制下降速度"
        ],
        targetMuscles: [.deltoids],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    ),
    Exercise(
        id: UUID(),
        name: "绳索下压",
        category: .arms,
        equipment: "绳索",
        description: "绳索下压是一个有效的三头肌孤立训练动作。",
        steps: [
            "面对高位滑轮，双手握住绳索",
            "上臂贴近身体两侧",
            "向下推压绳索直至手臂完全伸直",
            "缓慢回到起始位置"
        ],
        tips: [
            "保持上臂固定",
            "避免使用身体惯性",
            "专注于三头肌收缩",
            "动作要连贯流畅"
        ],
        targetMuscles: [.triceps],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    ),
    Exercise(
        id: UUID(),
        name: "悬挂举腿",
        category: .core,
        equipment: "单杠",
        description: "悬挂举腿是一个进阶的腹肌训练动作，可以强化整个核心区域。",
        steps: [
            "双手握住单杠悬挂",
            "收紧核心肌群",
            "抬起双腿至与地面平行或更高",
            "控制下降回到起始位置"
        ],
        tips: [
            "避免摆动身体",
            "保持腿部伸直",
            "控制动作速度",
            "注意呼吸节奏"
        ],
        targetMuscles: [.abdominals],
        videoURL: nil,
        images: [],
        difficulty: .advanced
    ),
    Exercise(
        id: UUID(),
        name: "硬拉",
        category: .back,
        equipment: "杠铃",
        description: "硬拉是一个全身性的复合训练动作，主要锻炼背部、臀部和腿部。",
        steps: [
            "站立在杠铃前，脚距与肩同宽",
            "弯腰握住杠铃，手距略宽于肩",
            "挺胸收腹，绷紧核心",
            "通过收紧臀部和大腿将杠铃提起",
            "髋关节和膝关节同时伸展",
            "达到直立位置后缓慢放下"
        ],
        tips: [
            "保持背部平直",
            "提起时保持杠铃贴近身体",
            "避免用背部发力",
            "下放时先推胯后弯腰"
        ],
        targetMuscles: [.latissimus, .hamstrings],
        videoURL: nil,
        images: [],
        difficulty: .advanced
    )
]

// 初级动作
let beginnerExercises = [
    Exercise(
        id: UUID(),
        name: "俯卧撑",
        category: .chest,
        equipment: "徒手",
        description: "俯卧撑是最基础的上半身力量训练动作，可以锻炼胸部、肩部和三头肌。",
        steps: [
            "手掌平放地面，与肩同宽",
            "身体呈直线，脚尖着地",
            "弯曲手臂，胸部下降至接近地面",
            "推起身体回到起始位置"
        ],
        tips: [
            "保持身体成一条直线",
            "肘部贴近身体",
            "呼吸要均匀"
        ],
        targetMuscles: [.pectoralis, .deltoids, .triceps],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    ),
    Exercise(
        id: UUID(),
        name: "空手深蹲",
        category: .legs,
        equipment: "徒手",
        description: "空手深蹲是训练下肢力量的基础动作。",
        steps: [
            "双脚略宽于肩",
            "脚尖稍微外旋",
            "臀部向后坐下",
            "膝盖与脚尖方向一致",
            "下蹲至大腿平行地面"
        ],
        tips: [
            "保持背部挺直",
            "膝盖不要超过脚尖",
            "下蹲时重心在脚跟"
        ],
        targetMuscles: [.quadriceps, .hamstrings],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    )
]

// 拉伸动作
let stretchExercises = [
    Exercise(
        id: UUID(),
        name: "胸部拉伸",
        category: .chest,
        equipment: "门框",
        description: "使用门框进行胸部拉伸，可以有效缓解胸部紧张。",
        steps: [
            "站在门框处",
            "手臂呈90度放在门框两侧",
            "身体微微前倾",
            "感受胸部拉伸",
            "保持15-30秒"
        ],
        tips: [
            "不要过度拉伸",
            "呼吸要均匀",
            "如果感觉疼痛要立即停止"
        ],
        targetMuscles: [.pectoralis],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    ),
    Exercise(
        id: UUID(),
        name: "腘绳肌拉伸",
        category: .legs,
        equipment: "徒手",
        description: "站姿腘绳肌拉伸，可以改善��部柔韧性。",
        steps: [
            "站立，一腿向前迈出",
            "后腿绷直",
            "前倾上身，臀部后推",
            "保持15-30秒"
        ],
        tips: [
            "保持背部平直",
            "不要弹跳",
            "前腿可以微微弯曲"
        ],
        targetMuscles: [.hamstrings],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    )
]

// 进阶动作
let advancedExercises = [
    Exercise(
        id: UUID(),
        name: "单腿深蹲",
        category: .legs,
        equipment: "徒手",
        description: "单腿深蹲是一个高难度的下肢训练动作，可以提高平衡能力和腿部力量。",
        steps: [
            "单腿站立，另一腿抬起",
            "保持平衡，开始下蹲",
            "下蹲至大腿平行地面",
            "推起身体返回起始位置"
        ],
        tips: [
            "保持核心收紧",
            "膝盖跟随脚尖方向",
            "可以先扶着墙练习"
        ],
        targetMuscles: [.quadriceps, .hamstrings],
        videoURL: nil,
        images: [],
        difficulty: .advanced
    )
]

// 核心训练动作
let coreExercises = [
    Exercise(
        id: UUID(),
        name: "平板支撑",
        category: .core,
        equipment: "徒手",
        description: "平板支撑是一个基础的核心训练动作，可以全面锻炼核心肌群。",
        steps: [
            "俯卧，用前臂和脚尖支撑身体",
            "保持身体成一条直线",
            "收紧腹部和臀部",
            "维持姿势30-60秒"
        ],
        tips: [
            "避免臀部下沉或抬高",
            "保持呼吸均匀",
            "注意颈部保持中立"
        ],
        targetMuscles: [.abdominals],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    ),
    Exercise(
        id: UUID(),
        name: "仰卧卷腹",
        category: .core,
        equipment: "徒手",
        description: "经典的腹肌训练动作，主要锻炼腹直肌。",
        steps: [
            "仰卧，屈膝，脚平放地面",
            "双手轻托头部",
            "收缩腹部，上身卷起",
            "缓慢返回起始位置"
        ],
        tips: [
            "不要用力拉扯头部",
            "动作要缓慢控制",
            "注意呼吸节奏"
        ],
        targetMuscles: [.abdominals],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    )
]

// 有氧运动动作
let cardioExercises = [
    Exercise(
        id: UUID(),
        name: "高抬腿",
        category: .core,
        equipment: "徒手",
        description: "原地高抬腿是一个有效的有氧训练动作，可以提高心肺功能。",
        steps: [
            "站立，双脚与肩同宽",
            "交替抬起膝盖至腰部高度",
            "手臂自然摆动",
            "保持节奏连续进行"
        ],
        tips: [
            "保持上身挺直",
            "控制呼吸节奏",
            "注意膝盖方向"
        ],
        targetMuscles: [.quadriceps],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    ),
    Exercise(
        id: UUID(),
        name: "开合跳",
        category: .legs,
        equipment: "徒手",
        description: "开合跳是一个全身性的有氧运动，可以快速提高心率。",
        steps: [
            "站立，双脚并拢",
            "跳起同时分开双脚，手臂向上举起",
            "落地时收回手臂和双脚",
            "连续进行动作"
        ],
        tips: [
            "注意落地缓冲",
            "保持动作节奏",
            "如感觉吃力可以放慢速度"
        ],
        targetMuscles: [.quadriceps, .hamstrings],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    )
]

// 热身动作
let warmupExercises = [
    Exercise(
        id: UUID(),
        name: "动态伸展",
        category: .core,
        equipment: "徒手",
        description: "训练前的动态伸展可以提高身体灵活性和预防受伤。",
        steps: [
            "站立，双脚与肩同宽",
            "手臂画圈，由小到大",
            "扭转躯干",
            "原地踏步提膝"
        ],
        tips: [
            "动作要缓慢控制",
            "不要过度拉伸",
            "注意身体感受"
        ],
        targetMuscles: [.deltoids],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    ),
    Exercise(
        id: UUID(),
        name: "关节活动",
        category: .core,
        equipment: "徒手",
        description: "活��全身主要关节，为训练做好准备。",
        steps: [
            "颈部轻轻转动",
            "肩关节前后画圈",
            "手腕脚踝转动",
            "髋关节画圈"
        ],
        tips: [
            "动作要轻柔",
            "注意活动范围",
            "如有不适及时停止"
        ],
        targetMuscles: [.deltoids],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    )
]

// 特定部位专项训练
let specializedExercises = [
    Exercise(
        id: UUID(),
        name: "侧平举",
        category: .shoulders,
        equipment: "哑铃",
        description: "侧平举是针对肩部中束的专项训练动作。",
        steps: [
            "站立，双手持哑铃垂于体侧",
            "保持手臂微屈，向两侧平举",
            "举至与肩同高",
            "缓慢下降回到起始位置"
        ],
        tips: [
            "避免耸肩",
            "控制下降速度",
            "保持正确姿势"
        ],
        targetMuscles: [.deltoids],
        videoURL: nil,
        images: [],
        difficulty: .intermediate
    ),
    Exercise(
        id: UUID(),
        name: "小腿提踵",
        category: .legs,
        equipment: "台阶",
        description: "站立提踵是针对小腿肌肉的专项训练。",
        steps: [
            "站在台阶边缘，脚跟悬空",
            "缓慢下降脚跟",
            "用力提起脚跟",
            "感受小腿收缩"
        ],
        tips: [
            "保持平衡",
            "动作要完整",
            "可单腿或双腿进行"
        ],
        targetMuscles: [.hamstrings],
        videoURL: nil,
        images: [],
        difficulty: .beginner
    )
]

// 组合所有动作
let allExercises = baseExercises + 
                  beginnerExercises + 
                  stretchExercises + 
                  advancedExercises +
                  coreExercises +
                  cardioExercises +
                  warmupExercises +
                  specializedExercises

// 更新示例数据
let sampleExercises = allExercises