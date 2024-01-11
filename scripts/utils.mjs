export function capitalizeFirstLetter(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
}

export function parseEmoji(emoji, skinTone) {
    let unified = emoji.u

    if (emoji.v.length > 0 && skinTone !== 'neutral') {
        unified = emoji.v.find(function (variation) {
            return variation.includes(skinTone)
        })
    }

    if (/-/.test(unified)) {
        return unified.split('-').map(hex => String.fromCodePoint(
                                          parseInt(hex, 16))).join('')
    }

    return String.fromCodePoint(parseInt(unified, 16))
}
