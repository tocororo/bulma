{if $languageToggleLocales && $languageToggleLocales|@count > 1}
    <div class="navbar-item has-dropdown is-hoverable">
        <a class="navbar-link">
        {translate key="plugins.themes.bulma.langswitch"}
            {* <span class="icon"><i class="fas fa-language" aria-hidden="true"></i></span> *}
        </a>
    
        <div class="navbar-dropdown is-right">
            {foreach from=$languageToggleLocales item=localeName key=localeKey}
                    <a class="navbar-item locale_{$localeKey|escape}{if $localeKey == $currentLocale} current{/if}"
                        href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path=$localeKey source=$smarty.server.REQUEST_URI}">
                        {$localeName}
                    </a>
            {/foreach}
    
            
        </div>
    </div>
    
{/if}    