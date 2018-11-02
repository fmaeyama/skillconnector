class EngineerDecorator < SkillConnectDecorator
    delegate_all
    include SkillHatContainer

    attr_reader :engineer_registration_types, :engineer_status_types,
        :skills, :business_types, :career_hats

    def initialize
        super
        self.model_name = Engineer.model_name.human
        @engineer_registration_types = EngineerRegistrationType.enable
        @engineer_status_types = EngineerStatusType.enable
        @skills = Skill.enable
        @business_types = BusinessType.enable(Date.new)
    end

end
