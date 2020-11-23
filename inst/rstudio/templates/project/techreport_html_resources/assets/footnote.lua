-- how many notes we've seen yet.
local note_number = 0

local fn_opening_template = [[<span id="fn-%d"><!--
--><label for="fn-%d-toggle"><sup>%d</sup></label><!--
--><input type="checkbox" hidden id="fn-%d-toggle"/>
]]
local fn_close = '</span>'

local style_css = [[<style>
input[type=checkbox][id|=fn] + span {display:none;}
input[type=checkbox][id|=fn]:checked + span {display:block;}
</style>
]]

-- Use custom HTML for footnotes.
function Note (note)
  note_number = note_number + 1
  local fn_open = fn_opening_template:format(
    note_number, note_number, note_number, note_number)
  return {
    pandoc.RawInline('html', fn_open),
    pandoc.Span(
      pandoc.utils.blocks_to_inlines(note.content),
      pandoc.Attr(string.format('fn-content'))
    ),
    pandoc.RawInline('html', fn_close)
  }
end

function Meta (meta)
  local header_includes = meta['header-includes']
  -- ensure that header_includes is a MetaList
  if not header_includes then
    header_includes = pandoc.MetaList{}
  elseif header_includes.t ~= 'MetaList' then
    header_includes = pandoc.MetaList {header_includes}
  end
  table.insert(
    header_includes,
    pandoc.MetaBlocks{pandoc.RawBlock('html', style_css)}
  )
  meta['header-includes'] = header_includes
  return meta
end
