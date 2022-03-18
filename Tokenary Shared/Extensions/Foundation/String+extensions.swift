// Copyright © 2022 Tokenary. All rights reserved.
// Helper extensions for working with `String` types

import Foundation

extension String {
    
    // MARK: Public Properties
    
    public var maybeJSON: Bool {
        self.hasPrefix(Symbols.leftCurlyBrace) && self.hasSuffix(Symbols.rightCurlyBrace) && self.count > 3
    }
    
    public var isOkAsPassword: Bool { self.count >= 4 }
    
    public var withFirstLetterCapitalized: String {
        guard !self.isEmpty else { return self }
        return self.prefix(1).uppercased() + self.dropFirst()
    }
    
    public var withEllipsis: String { self + Symbols.ellipsis }
    
    public var trimmedAddress: String {
        guard !self.isEmpty else { return self }
        let without0x = self.dropFirst(2)
        return without0x.prefix(4) + "..." + without0x.suffix(4)
    }
    
    // MARK: - Public Methods
    
    public func removingOccurrences(of substrings: [String]) -> String {
        var result = self
        substrings.forEach { character in
            result = result.replacingOccurrences(of: character, with: String.empty)
        }
        return result
    }
    
    public static func getRandomEmoticonsCollection(ofSize count: Int) -> [String] {
        var result: Set<String> = []
        outerLoop: for idx in .zero ..< count {
            while true {
                let valueToInsert: String
                if idx % 4 == .zero {
                    valueToInsert = String(
                        UnicodeScalar(String.validEmoticonUnicodeRange.randomElement()!) ?? String.defaultEmotion
                    )
                } else {
                    valueToInsert = String.validEmoticons.randomElement()!
                }
                
                let (inserted, _) = result.insert(valueToInsert)
                if inserted { continue outerLoop }
            }
        }
        return Array(result)
    }
    
    // MARK: - Private Properties
    
    // Authors favourites
    private static var defaultEmotion: Unicode.Scalar = "🔥"
    private static var defaultEmotion1: Unicode.Scalar = "💮"
    
    private static var validEmoticonUnicodeRange: ClosedRange = 0x1F600...0x1F64F
    
    private static var validEmoticons: [String] = [
        "🌀", "🌁", "🌂", "🌃", "🌄", "🌅", "🌆", "🌇", "🌈", "🌉", "🌊", "🌋", "🌌", "🌍", "🌎", "🌏",
        "🌐", "🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘", "🌙", "🌚", "🌛", "🌜", "🌝", "🌞", "🌟",
        "🌠", "🌡", "🌤", "🌥", "🌦", "🌧", "🌨", "🌩", "🌪", "🌫", "🌬", "🌭", "🌮", "🌯", "🌰", "🌱",
        "🌲", "🌳", "🌴", "🌵", "🌶", "🌷", "🌸", "🌹", "🌺", "🌻", "🌼", "🌽", "🌾", "🌿", "🍀", "🍁",
        "🍂", "🍃", "🍄", "🍅", "🍆", "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🍎", "🍏", "🍐", "🍑",
        "🍒", "🍓", "🍔", "🍕", "🍖", "🍗", "🍘", "🍙", "🍚", "🍛", "🍜", "🍝", "🍞", "🍟", "🍠", "🍡",
        "🍢", "🍣", "🍤", "🍥", "🍦", "🍧", "🍨", "🍩", "🍪", "🍫", "🍬", "🍭", "🍮", "🍯", "🍰", "🍱",
        "🍲", "🍳", "🍴", "🍵", "🍶", "🍷", "🍸", "🍹", "🍺", "🍻", "🍼", "🍽", "🍾", "🍿", "🎀", "🎁",
        "🎂", "🎖", "🎗", "🎃", "🎄", "🎅", "🎆", "🎇", "🎈", "🎉", "🎊", "🎋", "🎌", "🎍", "🎎", "🎞",
        "🎟", "🎠", "🎡", "🎢", "🎣", "🎤", "🎥", "🎦", "🎧", "🎨", "🎩", "🎪", "🎫", "🎬", "🎭", "🎮",
        "🎯", "🎰", "🎱", "🎲", "🎳", "🎴", "🎵", "🎶", "🎷", "🎸", "🎹", "🎺", "🎻", "🎼", "🎽", "🎾",
        "🎿", "🏀", "🏁", "🏂", "🏃", "🏄", "🏅", "🏆", "🏇", "🏈", "🏉", "🏊", "🏋", "🏌", "🏍", "🏎",
        "🏏", "🏐", "🏑", "🏒", "🏓", "🏔", "🏕", "🏖", "🏗", "🏘", "🏙", "🏚", "🏛", "🏜", "🏝", "🏞",
        "🏟", "🏠", "🏡", "🏢", "🏣", "🏤", "🐀", "🐁", "🐂", "🐃", "🐄", "🐅", "🐆", "🐇", "🐈", "🐉",
        "🐊", "🐋", "🐌", "🐍", "🐎", "🐏", "🐐", "🐑", "🐒", "🐓", "🐔", "🐕", "🐖", "🐗", "🐘", "🐙",
        "🐚", "🐛", "🐜", "🐝", "🐞", "🐟", "🐠", "🐡", "🐢", "🐣", "🐤", "🐥", "🐦", "🐧", "🐨", "🐩",
        "🐪", "🐫", "🐬", "🐭", "🐮", "🐯", "🐰", "🐱", "🐲", "🐳", "🐴", "🐵", "🐶", "🐷", "🐸", "🐹",
        "🐺", "🐻", "🐼", "🐽", "🐾", "🐿", "👀", "👁", "👂", "👃", "👄", "👅", "👆", "👇", "👈", "👉",
        "👊", "👋", "👌", "👍", "👎", "👏", "👐", "👑", "👒", "👓", "👔", "👕", "👖", "👗", "👘", "👙",
        "👚", "👛", "👜", "👝", "👞", "👟", "👠", "👡", "👢", "👣", "👤", "👥", "👦", "👧", "👨", "👩",
        "👪", "👫", "👬", "👭", "👮", "👯", "👰", "👱", "👲", "👳", "👴", "👵", "👶", "👷", "👸", "👹",
        "👺", "👻", "👼", "👽", "👾", "👿", "💀", "💁", "💂", "💃", "💄", "💅", "💆", "💇", "💈", "💉",
        "💊", "💋", "💌", "💍", "💎", "💏", "💐", "💑", "💒", "💓", "💔", "💕", "💖", "💗", "💘", "💙",
        "💚", "💛", "💜", "💝", "💞", "💟", "💠", "💡", "💢", "💣", "💤", "💥", "💦", "💧", "💨", "💩",
        "💪", "💫", "💬", "💭", "💮", "💯", "💰", "💱", "💲", "💳", "💴", "💵", "💶", "💷", "💸", "💹",
        "💺", "💻", "💼", "💽", "💾", "💿", "📀", "📁", "📂", "📃", "📄", "📅", "📆", "📇", "📈", "📉",
        "📊", "📋", "📌", "📍", "📎", "📏", "📐", "📑", "📒", "📓", "📔", "📕", "📖", "📗", "📘", "📙",
        "📚", "📛", "📜", "📝", "📞", "📟", "📠", "📡", "📢", "📣", "📤", "📥", "📦", "📧", "📨", "📩",
        "📪", "📫", "📬", "📭", "📮", "📯", "📰", "📱", "📲", "📳", "📴", "📵", "📶", "📷", "📸", "📹",
        "📺", "📻", "📼", "📽", "📿", "🔀", "🔁", "🔂", "🔃", "🔄", "🔅", "🔆", "🔇", "🔈", "🔉", "🔊",
        "🔋", "🔌", "🔍", "🔎", "🔏", "🔐", "🔑", "🔒", "🔓", "🔔", "🔬", "🔭", "🕐", "🗺", "🗻", "🗼",
        "🗽", "🗾", "🗿", "🖊", "🚀", "🚁", "🚂", "🚃", "🚄", "🚅", "🚆", "🚇", "🚈", "🚉", "🚊", "🚋",
        "🚌", "🚍", "🚎", "🚏", "🚐", "🚑", "🚒", "🚓", "🚔", "🚕", "🚖", "🚗", "🚘", "🚙", "🚚", "🚛",
        "🚜", "🚝", "🚞", "🚟", "🚠", "🚡", "🚢", "🚣", "🚤", "🚥", "🚦", "🚧", "🚨", "🚩", "🚪", "🚫",
        "🚬", "🚭", "🚮", "🚯", "🚰", "🔮", "🚱", "🚲", "🚳", "🚴", "🚵", "🚶", "✅", "✊", "❌", "🤌",
        "🤍", "🥇", "🥈", "🥉", "🥊", "🥋", "🥌", "🥍", "🥎", "🥏", "🥐", "🥑", "🥒", "🥓", "🥔", "🥕",
        "🥖", "🥗", "🥘", "🥙", "🥚", "🥛", "🥜", "🥝", "🥞", "🥟", "🥺", "🥻", "🥼", "🥽", "🥾", "🥿",
        "🦀", "🦁", "🦂", "🦃", "🦄", "🦅", "🦆", "🦇", "🦈", "🦉", "🦊", "🦋", "🦌", "🦍", "🦎", "🦏",
        "🦐", "🦑", "🦒", "🦓", "🦔", "🦕", "🦖", "🦗", "🦘", "🦙", "🦚", "🦛", "🦜", "🦝", "🦞", "🦟",
        "🦠", "🦡", "🦢", "🦣", "🧀", "🧁", "🧏", "🧐", "🧑", "🧒", "🧓", "🧔", "🧕", "🧖", "🧗", "🧘",
        "🧙", "🧚", "🧛", "🧜", "🧝", "🧞", "🧟", "🧠", "🧡", "🧢", "🧣", "🧤", "🧥", "🧦", "🧧", "🧨",
        "🧩", "🧪", "🧫", "🧬", "🧭", "🧮", "🧯", "🧰", "🧱", "🧲", "🧳", "🧴", "🧵", "🧶", "🧷", "🧸",
        "🧹", "🧺", "🧻", "🧼", "🧽", "🧾", "🧿", "🧂", "🧃", "🧄", "🧅", "🧆", "🧇", "🧈", "🧉", "🧊",
        "🧋", "🦤", "🦥", "🦦", "🦧", "🦨", "🦩", "🦪", "🦫", "🦬", "🦭", "🦮", "🦯", "🦰", "🦱", "🦲",
        "🦳", "🦴", "🦵", "🦶", "🦷", "🦸", "🦹", "🦺", "🦻", "🥠", "🥡", "🥢", "🥣", "🥤", "🥥", "🥦",
        "🥧", "🥨", "🥩", "🥪", "🥫", "🥬", "🥭", "🥮", "🥯", "🥰", "🥱", "🥲", "🥳", "🥴", "🥵", "🥶",
        "🥷", "🥸", "🤎", "🤏", "🤐", "🤯", "🤰", "🤱", "🤲", "🤳", "🤴", "🤵", "🤶", "🤷", "🤸", "🤹",
        "🤺", "🤑", "🤒", "🤓", "🤔", "🤕", "🤖", "🤗", "🤘", "🤙", "🤚", "🤛", "🤜", "🤝", "🤞", "🤟",
        "🤠", "🤡", "✋", "🚷", "❎", "🚸", "⛰", "⛱", "⛲", "⛳", "⛴", "⛵", "⛷", "⛸", "⛹", "⛺",
        "⛩", "⛪", "🛳", "🛴", "🛵", "🛶", "🛷", "🛸", "🛹", "🛺", "🛻", "🛼", "🚹", "🚺", "🚻", "🚼",
        "🚽", "🚾", "🚿", "🛀", "🛁", "🛂", "🛃", "🛄", "🛅", "🛋", "🛌", "🛍", "🛎", "🛏", "🛐", "🛑",
        "🛒", "🖋", "🖌", "🖍", "🕑", "🕒", "🕓", "🕔", "🕕", "🕖", "🕗", "🕳", "🕴", "🕵", "🕶", "🕷",
        "🕸", "🕹", "🕺", "🕘", "🕙", "🕚", "🕛", "🕜", "🕝", "🕞", "🕟", "🕠", "🕡", "🕢", "🕣", "🕤",
        "🕥", "🕦", "🕧", "🔕", "🔖", "🔗", "🔘", "🔙", "🔰", "🔱", "🔲", "🔳", "🔴", "🔵", "🔶", "🔷",
        "🔸", "🔹", "🔺", "🔻", "🔼", "🔽", "🔚", "🔛", "🔜", "🔝", "🔞", "🔟", "🔠", "🔡", "🔢", "🔣",
        "🔤", "🔥", "🏷", "🏸", "🏹", "🏺", "🏻", "🏥", "🏦", "🏧", "🏨", "🏩", "🏪", "🆎", "🆑", "🆒",
        "🆓", "🆔", "🆕", "🆖", "🆗", "🆘", "🆙", "🆚", "🏫", "🏬", "🏳", "🏴", "🏵", "🏭", "🏮", "🏯",
        "🏰", "🎏", "🎐", "🎑", "🎒", "🎓", "🈲", "🈳", "🈴", "🈵", "🈶", "🈸", "🈹", "🈺", "⏩", "⏪",
        "⏫", "⏬", "⏭", "⏮", "⏯", "⏰", "⏱", "⏲", "⏳", "⏸", "⏹", "⏺"
    ]
}
