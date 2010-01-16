
strings = []
strings[0] = "dsfasdfhksdfhdskjfh"
strings[1] = "working@HOME"
strings[2] = "andrea@VEGETA"
strings[3] = "sldfhfgsifisgffsisefseorweir andrea@andreadallera.com"
strings[4] = "ljdsf<em>test@test.se</em>"

strings.each do |string|

 p string.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)
end
