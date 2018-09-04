module SkillConnectsHelper
	def getParamCondVal(paramSet, key)
		return '' if paramSet.nil?
		return '' unless paramSet.key?(key)
		paramSet[key]
	end
end
